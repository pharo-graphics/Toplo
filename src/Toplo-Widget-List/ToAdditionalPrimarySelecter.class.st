Class {
	#name : #ToAdditionalPrimarySelecter,
	#superclass : #ToPrimarySelecter,
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #accessing }
ToAdditionalPrimarySelecter >> selectionModelInEventTarget: anEventTarget [

	^ anEventTarget selectionModel
]
