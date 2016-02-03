contract SimpleMultiSig {
     address exporter;
     address importer;
     address eximchain;
     uint numSigned = 0;
     bytes32 error;
     bool registeredYet;
     mapping (address => bool) signedYet;

     function SimpleMultiSig() {
       eximchain = msg.sender;
       registeredYet = false;
     }

     function register(address registerexporter, address registerimporter) {
       if (msg.sender == eximchain && registeredYet == false) {
           exporter = registerexporter;
           importer = registerimporter;
           registeredYet = true;
       } else if (msg.sender == eximchain) {
           error = "registered already";
       } else {
         error = "you are not eximchain!";
       }
   }

   function withdraw(address to) {
     if ((msg.sender == exporter || msg.sender == importer) && numSigned >= 2) {
        to.send(this.balance);
        numSigned = 0;
       signedYet[exporter] = signedYet[importer] = signedYet[eximchain] = false;
     } else {
        error = "cannot withdraw yet!";
     }
   }

   function addSignature() {
     if (msg.sender == exporter && signedYet[exporter]==false) {
       signedYet[exporter] = true;
       numSigned++;
     } else if (msg.sender == importer && signedYet[importer]==false) {
       signedYet[importer] = true;
       numSigned++;
     } else if (msg.sender == eximchain && signedYet[eximchain]==false) {
       signedYet[eximchain] = true;
       numSigned++;
     } else {
       error = 'unknown address';
     }
   }
}
