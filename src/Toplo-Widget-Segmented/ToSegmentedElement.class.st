Class {
	#name : #ToSegmentedElement,
	#superclass : #ToBarElement,
	#category : #'Toplo-Widget-Segmented'
}

{ #category : #initialization }
ToSegmentedElement >> defaultNodeManagerClass [ 

	^ ToSegmentManager 
]

{ #category : #accessing }
ToSegmentedElement >> segmentAccessor [
	"according to the specific vocabulary - the data items are segments of the segmented element "

	^ self dataAccessor
]
