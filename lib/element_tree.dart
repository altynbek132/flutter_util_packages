import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsBinding.instance.drawFrame();
  WidgetsBinding.instance.buildOwner.buildScope();
  for (final Element dirtyEl in dirtyEls) {
    dirtyEl.rebuild(); // ENTER LOOP
    performRebuildPolymorph(dirtyEl);
  }
}

void performRebuildPolymorph(Element dirtyEl) {
  dirtyEl.performRebuild(); // polymorph

  {
    (dirtyEl as ComponentElement).performRebuild(); // polymorphed
    {
      (dirtyEl as StatefulElement).performRebuild(); // polymorphed
      if (dirtyEl._didChangeDependencies) {
        (StatefulElement.state as State).didChangeDependencies();
      }
      (dirtyEl as StatefulElement).super.performRebuild();
    }
    final ComponentElement compEl = dirtyEl as ComponentElement;
    final Widget childW = compEl.build();
    compEl.childEl = updateChildPseudo(childW, compEl);
  }
  {
    (dirtyEl as RenderObjectElement).performRebuild(); // polymorphed
    final RenderObjectElement renderEl = dirtyEl as RenderObjectElement;
    (renderEl.widget as RenderObjectWidget).updateRenderObject();
  }
}

/// |child/newW|null                           |!null                        |
/// |:---------| :---------------------------- | --------------------------: |
/// |null      |null                           |new [Element]                |
/// |!null     |Old child removed, returns null|Old child updated if possible|
Element updateChildPseudo(Widget childW, Element el) {
  // original
  el.updateChild(el.childEl, childW, compEl.slot);

  final Element childEl = el.childEl;
  {
    // if childW == oldChildW : skip
    if (childW == null) {
      el.deactivate(childEl);
    }
    if (Widget.canUpdate) {
      updatePolymorph(childEl, childW);
    } else {
      if (cantUpdate) {
        el.deactivate(childEl);
      }
      el.inflateWidget(childW); // ENTER LOOP
      // try retake from global
      final Element newChildEl = childW.createElement();
      mountPolymorph(newChildEl);
    }
  }
  return newChildEl;
}

void updatePolymorph(Element el, Widget childW) {
  (el as Element).update(childW); // polymorph, must super
  {
    (el as ComponentElement).update(childW); // polymorph
    (el as StatefulElement).update(childW); // polymorph
    final el = (el as ComponentElement);
    // for stateful
    (el as StatefulElement).state.widget = newChildW;
    (el as StatefulElement).state.didUpdateWidget(newChildW);
    el.rebuild(); // LOOP
  }
  {
    (el as RenderObjectElement).update(childW); // polymorph
    final el = (el as RenderObjectElement);
    (el.widget as RenderObjectWidget).updateRenderObject(el, el.renderObject);
  }
  {
    (el as SingleChildRenderObjectElement).update(childW); // polymorph
    (el as RenderObjectElement).update(childW); // polymorph
    final el = (el as SingleChildRenderObjectElement);
    el._child = updateChild(el._child,
        (el.widget as SingleChildRenderObjectWidget).child, null); // LOOP
  }
  {
    (el as MultiChildRenderObjectElement).update(childW); // polymorph
    (el as RenderObjectElement).update(childW); // polymorph
    final el = (el as MultiChildRenderObjectElement);
    el.updateChildren(oldChildren, newWidgets);
    el.updateChild(child, newWidget, newSlot); // LOOP
  }
}

void mountPolymorph(Element el) {
  // registers global key, updates inh, attaches notifs
  (el as Element).mount();

  {
    (el as ComponentElement).mount(); // polymorphed
    (el as Element).mount(); // super
    final el = el as ComponentElement;
    el.rebuild(); // LOOP
  }
  {
    (el as RenderObjectElement).mount(); // polymorphed
    final el = el as RenderObjectElement;
    // create and attach render objs
  }
  {
    (el as SingleChildRenderObjectElement).mount(); // polymorphed
    (el as RenderObjectElement).mount(); // super
    final el = el as SingleChildRenderObjectElement;
    el.updateChild(el.child, (el.widget as SingleChildRenderObjectWidget).child,
        null); // LOOP
    updateChildPseudo();
  }
  {
    (el as MultiChildRenderObjectElement).mount(); // polymorphed
    (el as RenderObjectElement).mount(); // super
    final el = el as MultiChildRenderObjectElement;
    // for each child
    for (final Widget childW in el.widget.children) {
      el.children[i] =
          el.inflateWidget(childW, IndexedSlot(i, prevChildEl)); // LOOP
    }
  }
}
