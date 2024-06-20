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
