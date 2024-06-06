Class {
	#name : #ToSegmentedElement,
	#superclass : #ToBarElement,
	#instVars : [
		'group'
	],
	#category : #'Toplo-Widget-Segmented'
}

{ #category : #accessing }
ToSegmentedElement >> checkingStrategy: aCheckableGroupCheckingStrategy [

	group checkingStrategy: aCheckableGroupCheckingStrategy
	
]

{ #category : #initialization }
ToSegmentedElement >> defaultNodeManagerClass [ 

	^ ToSegmentManager 
]

{ #category : #initialization }
ToSegmentedElement >> initialize [ 

	super initialize.
	group := ToCheckableGroup new.
	self selectionMode selectOnMouseDown: true
]

{ #category : #accessing }
ToSegmentedElement >> segmentAccessor [
	"according to the specific vocabulary - the data items are segments of the segmented element "

	^ self dataAccessor
]
