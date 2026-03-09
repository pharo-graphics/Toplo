Class {
	#name : #ToSingleSelectPopupWindowManager,
	#superclass : #ToSelectPopupWindowManager,
	#category : #'Toplo-Widget-Select'
}

{ #category : #initialization }
ToSingleSelectPopupWindowManager >> listElementClass [

	^ ToSingleSelectPopupListElement
]
