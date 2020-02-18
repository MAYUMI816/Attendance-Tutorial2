# 10.6.1 退勤ボタンを表示しよう
module AttendancesHelper

  def attendance_state(attendance)
    # 受け取ったAttendanceオブジェクトが当日と一致するか評価します。
    if Date.current == attendance.worked_on
      return '出勤' if attendance.started_at.nil? #勤怠データが当日、かつ出勤時間が存在しない場合
      return '退勤' if attendance.started_at.present? && attendance.finished_at.nil? #勤怠データが当日、かつ出勤時間が登録済、かつ退勤時間が存在しない場合
    end
    # どれにも当てはまらなかった場合はfalseを返します。
    return false
  end
  # 10.8出勤時間と退勤時間を受け取り、在社時間を計算して返します。
  def working_times(start, finish)
    format("%.2f", (((finish - start) / 60) / 60.0))
  end
end