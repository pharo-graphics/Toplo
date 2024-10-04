Class {
	#name : #ToSecondarySelecter,
	#superclass : #ToListSelecter,
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #initialization }
ToSecondarySelecter >> initializeCommandApplier [

	commandApplier := ToDataSourceCommandApplier new.
	"commandApplier := ToDirectCommandApplier new."
	"commandApplier := ToQueueBasedCommandApplier new"
]
