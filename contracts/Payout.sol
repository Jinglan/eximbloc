contract Payout {
     address importer;
     address exporter;
     address eximchain;

     mapping (address => uint) ownershipDistribution; 

     function Setup() {
       importer = 0xaabb;
       exporter    = 0xccdd;
       eximchain = 0xeeff;

       ownershipDistribution[importer] = 35;
       ownershipDistribution[exporter]  = 35;
       ownershipDistribution[eximchain] = 30;
     }

     function Dividend() {
       uint bal= this.balance;
       importer.send(bal * ownershipDistribution[importer] / 100); 
       exporter.send(bal * ownershipDistribution[exporter] / 100);
       eximchain.send(bal * ownershipDistribution[eximchain] / 100);
     }
}
