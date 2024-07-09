Class {
	#name : #ToSecondarySelecter,
	#superclass : #ToListSelecter,
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #initialization }
ToSecondarySelecter >> initializeCommandApplier [

	commandApplierEventHandler := ToDataSourceCommandApplierEventHandler new.
	"commandApplierEventHandler := ToDirectCommandApplierEventHandler new."
	"commandApplierEventHandler := ToQueueBasedCommandApplierEventHandler new"
]
