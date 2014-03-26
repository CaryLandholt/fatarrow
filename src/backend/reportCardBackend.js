var ReportCardBackend,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

ReportCardBackend = (function(_super) {
  __extends(ReportCardBackend, _super);

  function ReportCardBackend($log, $httpBackend) {
    this.$log = $log;
    this.$httpBackend = $httpBackend;
    this.$httpBackend.whenGET(/osrc.dfm.io/).passThrough();
  }

  return ReportCardBackend;

})(Run);
