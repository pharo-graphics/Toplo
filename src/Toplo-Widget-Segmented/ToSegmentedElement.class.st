Class {
	#name : #ToSegmentedElement,
	#superclass : #ToBarElement,
	#category : #'Toplo-Widget-Segmented'
}

{ #category : #initialization }
ToSegmentedElement >> defaultInnerContainer [

	^ ToSegmentedInnerBarElement onBarElement: self
]

{ #category : #initialization }
ToSegmentedElement >> defaultNodeManagerClass [ 

	^ ToSegmentManager 
]

{ #category : #'instance creation' }
ToSegmentedElement >> newPrimarySelectionEventHandler [

	^ ToSegmentedPrimarySelectionElementEventHandler new
]

{ #category : #accessing }
ToSegmentedElement >> segmentAccessor [
	"according to the specific vocabulary - the data items are segments of the segmented element "

	^ self dataAccessor
]
