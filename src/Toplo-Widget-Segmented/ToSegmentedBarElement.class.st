Class {
	#name : #ToSegmentedBarElement,
	#superclass : #ToCheckableBarElement,
	#category : #'Toplo-Widget-Segmented'
}

{ #category : #initialization }
ToSegmentedBarElement >> defaultInnerContainer [

	^ ToSegmentedInnerBarElement onBarElement: self
]

{ #category : #initialization }
ToSegmentedBarElement >> defaultNodeManagerClass [ 

	^ ToSegmentNodeManager 
]
