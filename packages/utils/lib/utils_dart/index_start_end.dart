(int start, int end) indexStartEnd(int length, int start, [int? end]) {
  end ??= length;
  if (end > length) {
    end = length;
  }
  if (start > length) {
    start = length;
  }
  if (end < 0) {
    end = length + end;
  }
  if (start < 0) {
    start = length + start;
  }
  if (start > end) {
    start = end;
  }
  return (start, end);
}
