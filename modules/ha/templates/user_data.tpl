Content-Type: multipart/mixed; boundary="===============0086047718136476635=="
MIME-Version: 1.0

--===============0086047718136476635==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="config"

config system global
    set hostname "${fmg_vm_name}"
    set management-port "${fmg_admin_port}"
    set adom-status enable
    set clone-name-option keep
    set create-revision enable
    set device-view-mode tree
    set disable-module fortiview-noc
    set import-ignore-addr-cmt enable
    set partial-install enable
    set partial-install-force enable
    set partial-install-rev enable
    set perform-improve-by-ha enable
    set policy-hit-count enable
    set policy-object-icon enable
    set search-all-adoms enable
end
config system admin setting
    set gui-theme spring
    set idle_timeout 480
    set sdwan-monitor-history enable
    set show-add-multiple enable
    set show-checkbox-in-table enable
    set show-device-import-export enable
    set show-hostname enable
    set show_automatic_script enable
    set show_schedule_script enable
    set show_tcl_script enable
end
%{ if fmg_license_fortiflex != "" }
exec vm-license ${fmg_license_fortiflex}
%{ endif }
config system ha
    set failover-mode vrrp
	set clusterid 10
    set hb-interval 5
    set hb-lost-threshold 10
        config peer
            edit 1
                set ip ${peer_ipaddr}
                set serial-number ${peer_serial_number}
            next
        end
    set priority ${ha_priority}
    set unicast enable
    set password ${ha_password}
    set vip ${ha_ipaddr}
    set vrrp-interface "port1"
end

%{ if fmg_license_file != "" }
--===============0086047718136476635==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="${fmg_license_file}"

${file(fmg_license_file)}

%{ endif }
--===============0086047718136476635==--
