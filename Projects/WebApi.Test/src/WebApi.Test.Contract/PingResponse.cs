using System;
using System.Runtime.Serialization;

namespace WebApi.Test.Contract
{
    [DataContract]
    public class PingResponse
    {
        [DataMember]
        public string Echo { get; set; }
    }
}
