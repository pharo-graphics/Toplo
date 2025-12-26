Class {
	#name : #ToSingleSelectPopupListElement,
	#superclass : #ToSelectPopupListElement,
	#category : #'Toplo-Widget-Select-PopupList'
}

{ #category : #initialization }
ToSingleSelectPopupListElement >> defaultEventHandler [

	^ ToSingleSelectPopupListElementEventHandler new
]

{ #category : #initialization }
ToSingleSelectPopupListElement >> defaultNodeManager [

	^ self defaultNodeManagerClass new
		  nodeHolderFactory: [ ToSelectPopupListNodeHolder new ];
		  yourself
]

{ #category : #initialization }
ToSingleSelectPopupListElement >> listNodeClass [

	^ ToSelectPopupListNode
]
