Class {
	#name : #ToSieveSelecter,
	#superclass : #ToCompositeSelecter,
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #initialization }
ToSieveSelecter >> initializeCommandApplier [

	commandApplier := ToDirectCommandApplier new
]

{ #category : #'event firing' }
ToSieveSelecter >> notifyPrimarySelectionDirty [

	
]
