using GLib;

namespace ev3dev_lang {
    public class DCMotor : MotorBase {

        public DCMotor (string port = "") {
            this.motor_device_dir = "/sys/class/dc-motor";
            base (port);
        }

        //PROPERTIES

        //~autogen vala_generic-get-set classes.dcMotor>currentClass
        public string command {
            set {
                this.write_string ("command", value);
            }
        }

        public int duty_cycle {
            get {
                return this.read_int ("duty_cycle");
            }
            set {
                this.write_int ("duty_cycle", value);
            }
        }

        public string device_name {
            owned get {
                return this.read_string ("device_name");
            }
        }

        public string port_name {
            owned get {
                return this.read_string ("port_name");
            }
        }

        public int ramp_down_ms {
            get {
                return this.read_int ("ramp_down_ms");
            }
            set {
                this.write_int ("ramp_down_ms", value);
            }
        }

        public int ramp_up_ms {
            get {
                return this.read_int ("ramp_up_ms");
            }
            set {
                this.write_int ("ramp_up_ms", value);
            }
        }

        public string polarity {
            owned get {
                return this.read_string ("polarity");
            }
            set {
                this.write_string ("polarity", value);
            }
        }
        //~autogen
    }
}