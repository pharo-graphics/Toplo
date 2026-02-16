Class {
	#name : #ToSegmentedListElement,
	#superclass : #ToCheckableListElement,
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #initialization }
ToSegmentedListElement >> defaultInnerElementClass [ 

	^ ToFiniteListElement
]

{ #category : #initialization }
ToSegmentedListElement >> defaultNodeManagerClass [

	^ ToSegmentedListNodeManager
]

{ #category : #initialization }
ToSegmentedListElement >> initialize [ 

	super initialize.
	self selectionOption masked: true.
	self secondarySelectionOption masked: true
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
