Class {
	#name : #ToSegmentedListElement,
	#superclass : #ToCheckableListElement,
	#category : #'Toplo-Widget-List'
}

{ #category : #initialization }
ToSegmentedListElement >> defaultInnerElementClass [ 

	^ ToFiniteListElement
]

{ #category : #initialization }
ToSegmentedListElement >> defaultNodeManagerClass [

	^ ToSegmentedListNodeManager
]

{ #category : #skin }
ToSegmentedListElement >> newRawSkin [ 

	^ ToSegmentedListElementSkin new
]

{ #category : #'t - item list - adding/removing' }
ToSegmentedListElement >> onAddedItem: anItem [

	super onAddedItem: anItem.
	anItem addStamp: #borderless
]
