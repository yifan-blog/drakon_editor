namespace eval gen_js {


# Autogenerated with DRAKON Editor 1.28
######### Public #########
proc reset_db {  } {
    variable f_task_rcount
    array unset f_task_rcount
    array set f_task_rcount {}

    variable f_task_type_id
    array unset f_task_type_id
    array set f_task_type_id {}

    variable f_task_name
    array unset f_task_name
    array set f_task_name {}

    variable f_task_properties
    array unset f_task_properties
    array set f_task_properties {}

    variable f_property_rcount
    array unset f_property_rcount
    array set f_property_rcount {}

    variable f_property_type_id
    array unset f_property_type_id
    array set f_property_type_id {}

    variable f_property_task
    array unset f_property_task
    array set f_property_task {}

    variable f_property_name
    array unset f_property_name
    array set f_property_name {}

    variable f_property_is_empty
    array unset f_property_is_empty
    array set f_property_is_empty {}

    variable i_task_name
    array unset i_task_name
    array set i_task_name {}

    variable i_property_task_name
    array unset i_property_task_name
    array set i_property_task_name {}

    variable g_task_next
    set g_task_next 1
    variable g_property_next
    set g_property_next 1
}
proc task_keys {  } {
    variable f_task_rcount
    set names [ array names f_task_rcount ]
    return $names
}
proc task_count {  } {
    variable f_task_rcount
    set names [ array names f_task_rcount ]
    return [ llength $names ]
}
proc task_exists { id } {
    variable f_task_rcount
    return [ info exists f_task_rcount($id) ]
}
proc task_insert { id name } {
    variable g_task_next
    if { $id == {} } {
        set id $g_task_next
    } else {
        if { [ task_exists $id ] } {
            set class_name [ get_task_type_id $id ]
            error "'$class_name' with id $id already exists."
        }
    }
    if { $id >= $g_task_next } {
        set g_task_next [ expr { $id + 1 } ]
    }
    variable i_task_name
    set _key_ "$name"
    if { [ info exists i_task_name($_key_) ] } {
        error "Fields 'name' are not unique for 'task'."
    }
    variable f_task_type_id
    set f_task_type_id($id) "task"
    variable f_task_rcount
    set f_task_rcount($id) 0
    variable f_task_name
    set f_task_name($id) $name
    variable i_task_name
    set _key_ "$name"
    set i_task_name($_key_) $id
    return $id
}
proc get_task_type_id { id } {
    variable f_task_type_id
    if { [ info exists f_task_type_id($id) ] } {
        return $f_task_type_id($id)
    } else {
        return {}
    }
}
proc task_delete { id } {
    variable g_del_list
    array unset g_del_list
    array set g_del_list {}

    if { ![ task_exists $id ] } {
        error "'task' with id '$id' does not exist."
    }
    task_pre_delete $id
    foreach item [ array names g_del_list ] {
        lassign [ split $item "," ] pk type
        set proc_name "${type}_can_delete"
        $proc_name $pk
    }
    foreach item [ array names g_del_list ] {
        lassign [ split $item "," ] pk type
        set proc_name "${type}_do_delete"
        $proc_name $pk
    }
    variable f_task_type_id
    unset f_task_type_id($id)
}
proc find_task_by_name { name } {
    variable i_task_name
    set _key_ "$name"
    if { [ info exists i_task_name($_key_) ] } {
        return $i_task_name($_key_)
    } else {
        return {}
    }
}
proc get_task_name { id } {
    variable f_task_name
    if { [ info exists f_task_name($id) ] } {
        return $f_task_name($id)
    } else {
        return {}
    }
}
proc set_task_name { id name } {
    if { ![ task_exists $id ] } {
        error "'task' with id '$id' does not exist."
    }
    set old [ get_task_name $id ]
    if { $old == $name } {
        return
    }
    variable i_task_name
    set _key_ "$name"
    if { [ info exists i_task_name($_key_) ] } {
        error "Fields 'name' are not unique for 'task'."
    }
    set _key_ "$old"
    unset i_task_name($_key_)
    variable f_task_name
    set f_task_name($id) $name
    variable i_task_name
    set _key_ "$name"
    set i_task_name($_key_) $id
}
proc get_task_properties { id } {
    variable f_task_properties
    if { [ info exists f_task_properties($id) ] } {
        return $f_task_properties($id)
    } else {
        return {}
    }
}
proc property_keys {  } {
    variable f_property_rcount
    set names [ array names f_property_rcount ]
    return $names
}
proc property_count {  } {
    variable f_property_rcount
    set names [ array names f_property_rcount ]
    return [ llength $names ]
}
proc property_exists { id } {
    variable f_property_rcount
    return [ info exists f_property_rcount($id) ]
}
proc property_insert { id task name } {
    variable g_property_next
    if { $id == {} } {
        set id $g_property_next
    } else {
        if { [ property_exists $id ] } {
            set class_name [ get_property_type_id $id ]
            error "'$class_name' with id $id already exists."
        }
    }
    if { $id >= $g_property_next } {
        set g_property_next [ expr { $id + 1 } ]
    }
    variable i_property_task_name
    set _key_ "$task,|,$name"
    if { [ info exists i_property_task_name($_key_) ] } {
        error "Fields 'task name' are not unique for 'property'."
    }
    if { $task != {} && ![ task_exists $task ] } {
        error "'task' with id '$task' does not exist."
    }
    variable f_property_type_id
    set f_property_type_id($id) "property"
    variable f_property_rcount
    set f_property_rcount($id) 0
    variable f_property_task
    set f_property_task($id) $task
    variable f_property_name
    set f_property_name($id) $name
    variable i_property_task_name
    set _key_ "$task,|,$name"
    set i_property_task_name($_key_) $id
    if { $task != {} } {
        variable f_task_properties
        if { [ info exists f_task_properties($task) ] } {
            set _col_ $f_task_properties($task)
        } else {
            set _col_ {}
        }
        lappend _col_ $id
        set f_task_properties($task) $_col_
    }
    return $id
}
proc get_property_type_id { id } {
    variable f_property_type_id
    if { [ info exists f_property_type_id($id) ] } {
        return $f_property_type_id($id)
    } else {
        return {}
    }
}
proc property_delete { id } {
    variable g_del_list
    array unset g_del_list
    array set g_del_list {}

    if { ![ property_exists $id ] } {
        error "'property' with id '$id' does not exist."
    }
    property_pre_delete $id
    foreach item [ array names g_del_list ] {
        lassign [ split $item "," ] pk type
        set proc_name "${type}_can_delete"
        $proc_name $pk
    }
    foreach item [ array names g_del_list ] {
        lassign [ split $item "," ] pk type
        set proc_name "${type}_do_delete"
        $proc_name $pk
    }
    variable f_property_type_id
    unset f_property_type_id($id)
}
proc find_property_by_task_name { task name } {
    variable i_property_task_name
    set _key_ "$task,|,$name"
    if { [ info exists i_property_task_name($_key_) ] } {
        return $i_property_task_name($_key_)
    } else {
        return {}
    }
}
proc get_property_task { id } {
    variable f_property_task
    if { [ info exists f_property_task($id) ] } {
        return $f_property_task($id)
    } else {
        return {}
    }
}
proc set_property_task { id task } {
    if { ![ property_exists $id ] } {
        error "'property' with id '$id' does not exist."
    }
    set old [ get_property_task $id ]
    if { $old == $task } {
        return
    }
    set name [ get_property_name $id ]
    variable i_property_task_name
    set _key_ "$task,|,$name"
    if { [ info exists i_property_task_name($_key_) ] } {
        error "Fields 'task name' are not unique for 'property'."
    }
    if { $task != {} && ![ task_exists $task ] } {
        error "'task' with id '$task' does not exist."
    }
    if { $old != {} } {
        variable f_task_properties
        if { [ info exists f_task_properties($old) ] } {
            set _col_ $f_task_properties($old)
            set _index_ [ lsearch $_col_ $id ]
            if { $_index_ != -1 } {
                set _col_2 [ lreplace $_col_ $_index_ $_index_ ]
                set f_task_properties($old) $_col_2
            }
        }
    }
    set _key_ "$old,|,$name"
    unset i_property_task_name($_key_)
    variable f_property_task
    set f_property_task($id) $task
    variable i_property_task_name
    set _key_ "$task,|,$name"
    set i_property_task_name($_key_) $id
    if { $task != {} } {
        variable f_task_properties
        if { [ info exists f_task_properties($task) ] } {
            set _col_ $f_task_properties($task)
        } else {
            set _col_ {}
        }
        lappend _col_ $id
        set f_task_properties($task) $_col_
    }
}
proc get_property_name { id } {
    variable f_property_name
    if { [ info exists f_property_name($id) ] } {
        return $f_property_name($id)
    } else {
        return {}
    }
}
proc set_property_name { id name } {
    if { ![ property_exists $id ] } {
        error "'property' with id '$id' does not exist."
    }
    set old [ get_property_name $id ]
    if { $old == $name } {
        return
    }
    set task [ get_property_task $id ]
    variable i_property_task_name
    set _key_ "$task,|,$name"
    if { [ info exists i_property_task_name($_key_) ] } {
        error "Fields 'task name' are not unique for 'property'."
    }
    set _key_ "$task,|,$old"
    unset i_property_task_name($_key_)
    variable f_property_name
    set f_property_name($id) $name
    variable i_property_task_name
    set _key_ "$task,|,$name"
    set i_property_task_name($_key_) $id
}
proc get_property_is_empty { id } {
    variable f_property_is_empty
    if { [ info exists f_property_is_empty($id) ] } {
        return $f_property_is_empty($id)
    } else {
        return {}
    }
}
proc set_property_is_empty { id is_empty } {
    variable f_property_is_empty
    set f_property_is_empty($id) $is_empty
}
######### Private #########
variable g_del_list
array set g_del_list {}
variable f_task_rcount
array set f_task_rcount {}
variable f_task_type_id
array set f_task_type_id {}
variable g_task_next 1
variable f_task_name
array set f_task_name {}
variable f_task_properties
array set f_task_properties {}
variable f_property_rcount
array set f_property_rcount {}
variable f_property_type_id
array set f_property_type_id {}
variable g_property_next 1
variable f_property_task
array set f_property_task {}
variable f_property_name
array set f_property_name {}
variable f_property_is_empty
array set f_property_is_empty {}
variable i_task_name
array set i_task_name {}
variable i_property_task_name
array set i_property_task_name {}
proc task_pre_delete { id } {
    set type [ get_task_type_id $id ]
    variable g_del_list
    set key "$id,$type"
    if { [ info exists g_del_list($key) ] } {
        return
    } else {
        set g_del_list($key) 1
    }
    ${type}_pre_delete_middle $id
}
proc task_pre_delete_middle { id } {
    task_pre_delete_inner $id
}
proc task_pre_delete_inner { id } {
}
proc task_can_delete { id } {
    set properties [ get_task_properties $id ]
    foreach that $properties {
        variable g_del_list
        set _type_ [ get_property_type_id $that ]
        set _key_ "$that,$_type_"
        if { ![ info exists g_del_list($_key_) ] } {
            error "'task' with id '$id' is referenced by other record."
        }
    }
}
proc task_do_delete { id } {
    set name [ get_task_name $id ]
    variable i_task_name
    set _key_ "$name"
    unset i_task_name($_key_)
    variable f_task_name
    if { [ info exists f_task_name($id) ] } {
        unset f_task_name($id)
    }
    variable f_task_properties
    if { [ info exists f_task_properties($id) ] } {
        unset f_task_properties($id)
    }
    variable f_task_rcount
    unset f_task_rcount($id)
}
proc property_pre_delete { id } {
    set type [ get_property_type_id $id ]
    variable g_del_list
    set key "$id,$type"
    if { [ info exists g_del_list($key) ] } {
        return
    } else {
        set g_del_list($key) 1
    }
    ${type}_pre_delete_middle $id
}
proc property_pre_delete_middle { id } {
    property_pre_delete_inner $id
}
proc property_pre_delete_inner { id } {
}
proc property_can_delete { id } {
}
proc property_do_delete { id } {
    set task [ get_property_task $id ]
    if { $task != {} } {
        variable g_del_list
        set _type_ [ get_task_type_id $task ]
        set _key_ "$task,$_type_"
        if { ![ info exists g_del_list($_key_) ] } {
            variable f_task_properties
            if { [ info exists f_task_properties($task) ] } {
                set _col_ $f_task_properties($task)
                set _index_ [ lsearch $_col_ $id ]
                if { $_index_ != -1 } {
                    set _col_2 [ lreplace $_col_ $_index_ $_index_ ]
                    set f_task_properties($task) $_col_2
                }
            }
        }
    }
    set task [ get_property_task $id ]
    set name [ get_property_name $id ]
    variable i_property_task_name
    set _key_ "$task,|,$name"
    unset i_property_task_name($_key_)
    variable f_property_task
    if { [ info exists f_property_task($id) ] } {
        unset f_property_task($id)
    }
    variable f_property_name
    if { [ info exists f_property_name($id) ] } {
        unset f_property_name($id)
    }
    variable f_property_is_empty
    if { [ info exists f_property_is_empty($id) ] } {
        unset f_property_is_empty($id)
    }
    variable f_property_rcount
    unset f_property_rcount($id)
}

proc build_task_proc { task } {
    #item 111
    set task_id [ find_task_by_name $task ]
    #item 114
    set props [ get_task_properties $task_id ]
    #item 115
    set body {}
    foreach prop_id $props {
        #item 118
        set prop [ get_property_name $prop_id ]
        set is_empty [ get_property_is_empty $prop_id ]
        #item 123
        lappend body "this._$prop = null"
        #item 120
        if {$is_empty} {
            #item 128
            lappend body "this.$prop = function\(newValue\) \{"
            lappend body "    if \(typeof newValue != \"undefined\"\) \{"
            lappend body "        this._$prop = newValue"
            lappend body "        return"  
            lappend body "    \}"
            #item 126
            lappend body "    return this._$prop"
        } else {
            #item 129
            lappend body "this.$prop = function\(\) \{"
            #item 125
            lappend body "    var value = this._$prop"
            lappend body "    if \(value != null\) \{"
            lappend body "        return value"
            lappend body "    \}"
            #item 119
            lappend body "    value = ${task}_${prop}.call\(this\)"
            #item 127
            lappend body "    this._$prop = value"
            lappend body "    return value"
        }
        #item 124
        lappend body "\}"
    }
    #item 113
    return [list -1 $task {procedure public {} {}} $body]
}

proc build_tasks { functions } {
    #item 74
    reset_db
    #item 75
    set tasks {}
    foreach fun $functions {
        #item 45
        lassign $fun id name signature body
        #item 76
        lassign [ parse_name $name ] task prop
        #item 46
        lappend tasks $task
    }
    #item 78
    set tasks [ lsort -unique $tasks ]
    foreach task $tasks {
        #item 84
        task_insert "" $task
    }
    foreach fun $functions {
        #item 71
        lassign $fun id name signature body
        #item 86
        lassign [ parse_name $name ] task prop
        #item 73
        set is_empty \
        [is_empty_body $body]
        #item 91
        set task_id [ find_task_by_name $task ]
        #item 87
        set prop_id \
        [property_insert "" $task_id $prop]
        #item 72
        set_property_is_empty $prop_id $is_empty
    }
    foreach task $tasks {
        #item 95
        set task_proc [ build_task_proc $task ]
        #item 96
        lappend functions $task_proc
    }
    #item 44
    return $functions
}

proc contains_dot { text } {
    #item 11
    set pos \
    [string first "." $text]
    #item 7
    if {$pos == -1} {
        #item 10
        return 0
    } else {
        #item 6
        return 1
    }
}

proc is_empty_body { body } {
    #item 52
    if {[llength $body] == 1} {
        #item 55
        set line1 [ lindex $body 0 ]
        #item 56
        if {$line1 == {}} {
            #item 57
            return 1
        } else {
            #item 58
            return 0
        }
    } else {
        #item 58
        return 0
    }
}

proc normalize_name { text } {
    #item 25
    if {[contains_dot $text]} {
        #item 29
        set parts \
        [parse_name $text]
        #item 28
        return [ join $parts "_" ]
    } else {
        #item 30
        return $text
    }
}

proc parse_name { text } {
    #item 18
    set parts \
    [split $text "."]
    #item 19
    return $parts
}

}
