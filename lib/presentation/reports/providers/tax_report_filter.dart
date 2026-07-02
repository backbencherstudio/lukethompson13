import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lukethompson/presentation/reports/view/widget/tax_period_selector.dart';

class TaxReportFilter {
  final DateTimeRange? dateRange;
  final DateRangeType type;

  const TaxReportFilter({this.dateRange, this.type = DateRangeType.monthly});

  TaxReportFilter copyWith({DateTimeRange? dateRange, DateRangeType? type}) {
    return TaxReportFilter(
      dateRange: dateRange ?? this.dateRange,
      type: type ?? this.type,
    );
  }
}

class TaxReportFilterNotifier extends Notifier<TaxReportFilter> {
  @override
  TaxReportFilter build() => const TaxReportFilter();

  void setDateRange(DateTimeRange? range) {
    state = state.copyWith(dateRange: range);
  }

  void setType(DateRangeType? type) {
    if (type != null) {
      state = state.copyWith(type: type);
    }
  }
}

final taxReportFilterProvider =
    NotifierProvider<TaxReportFilterNotifier, TaxReportFilter>(
  TaxReportFilterNotifier.new,
);
