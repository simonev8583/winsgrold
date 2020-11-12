
namespace SistemaGestionRedes
{
    public static class TypeOfDevice
    {
        /// <summary>
        /// identifier should be the SERIAL of device
        /// param name="identifier"
        /// </summary>
        public static bool IsArix(string identifier)
        {
            string Id = identifier.Substring(0, 2).ToUpper();
            const string _RI = "RI";
            const string _R = "R";
            return (Id.Equals(_RI) || Id.Substring(0, 1).Equals(_R));
        }

        /// <summary>
        /// identifier should be the SERIAL of device
        /// param name="identifier"
        /// </summary>
        public static bool IsFci(string identifier)
        {
            string Id = identifier.Substring(0, 2).ToUpper();
            const string _FI = "FI";
            const string _F = "F";
            return (Id.Equals(_FI) || Id.Substring(0, 1).Equals(_F));
        }

        /// <summary>
        /// identifier should be the SERIAL of device
        /// param name="identifier"
        /// </summary>
        public static bool IsSix(string identifier)
        {
            string Id = identifier.Substring(0, 1).ToUpper();
            const string _C = "C";
            const string _S = "S";
            return (Id.Equals(_C) || Id.Equals(_S));
        }
    }
}