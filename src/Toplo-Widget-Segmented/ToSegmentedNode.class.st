Class {
	#name : #ToSegmentedNode,
	#superclass : #ToBarNode,
	#classTraits : 'TToCheckable classTrait',
	#category : #'Toplo-Widget-Segmented'
}

{ #category : #'t - list node' }
ToSegmentedNode >> clickEventHandlerClasses [

	^  { ToSegmentedNodeEventHandler } 
]

{ #category : #accessing }
ToSegmentedNode >> content [ 

	^ self firstChild
]

{ #category : #testing }
ToSegmentedNode >> isFirst [

	^ self holder position = 1
]

{ #category : #testing }
ToSegmentedNode >> isHorizontal [

	^ self holder segmentedBarElement isHorizontal
]

{ #category : #testing }
ToSegmentedNode >> isLast [

	^ self holder position = self holder dataSource itemCount 
]

{ #category : #skin }
ToSegmentedNode >> newRawSkin [ 

	^ ToSegmentedNodeSkin new
]
