Class {
	#name : #ToSingleSelectPopupWindowManager,
	#superclass : #ToSelectPopupWindowManager,
	#category : #'Toplo-Widget-Select-PopupWindow'
}

{ #category : #initialization }
ToSingleSelectPopupWindowManager >> listElementClass [

	^ ToSingleSelectPopupListElement
]
