class AttachPackagesAndLinesToRealCuts < ActiveRecord::Migration
  def up
    add_column :lines, :real_cut_id, :integer
    add_index  :lines, :real_cut_id

    Line.find_each do |line|
      real_cut = RealCut.find_by_cut_id_and_animal_id(line.cut_id, line.order.animal_id)
      line.update_attribute(:real_cut_id, real_cut.id)
    end

    if Line.where(real_cut_id: nil).count == 0
      remove_column :lines, :cut_id
    end
  end

  def down
    add_column :lines, :cut_id, :integer

    Line.find_each do |line|
      line.update_attribute(:cut_id, line.real_cut.cut_id)
    end

    if Line.where(cut_id: nil).count == 0
      remove_column :lines, :real_cut_id
      remove_index :lines, :real_cut_id
    end
  end
end
