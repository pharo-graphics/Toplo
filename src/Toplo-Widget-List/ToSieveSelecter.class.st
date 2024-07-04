Class {
	#name : #ToSieveSelecter,
	#superclass : #ToCompositeSelecter,
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #initialization }
ToSieveSelecter >> initializeCommandApplier [

	commandApplierEventHandler := ToDirectCommandApplierEventHandler new
]
