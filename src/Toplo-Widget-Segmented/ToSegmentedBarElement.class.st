Class {
	#name : #ToSegmentedBarElement,
	#superclass : #ToCheckableBarElement,
	#category : #'Toplo-Widget-Segmented'
}

{ #category : #visiting }
ToSegmentedBarElement >> accept: aVisitor [

	aVisitor visitSegmentedBarElement: self
]

{ #category : #testing }
ToSegmentedBarElement >> canMatchParentHorizontallyInVerticalSegmented [

	^ nodeWrapping not
]

{ #category : #initialization }
ToSegmentedBarElement >> defaultNodeManagerClass [ 

	^ ToSegmentNodeManager 
]

{ #category : #layout }
ToSegmentedBarElement >> layoutConfigurator [ 

	^ ToSegmentedConfigurator new
]
