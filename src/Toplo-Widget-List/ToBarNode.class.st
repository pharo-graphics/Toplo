Class {
	#name : #ToBarNode,
	#superclass : #ToAbstractListNode,
	#traits : 'TToBarNode',
	#classTraits : 'TToBarNode classTrait',
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #'t - list node' }
ToBarNode >> clickEventHandlerClasses [

	^  { ToListNodeMultiSelectionClickEventHandler } 
]

{ #category : #skin }
ToBarNode >> newRawSkin [ 

	^ ToBarNodeSkin new
]

{ #category : #'instance creation' }
ToBarNode >> newWidgetConfiguration [

	^ ToConfigurationAction new action: [ :aNode |
		  | bar |
		  bar := aNode holder listElement.
		  bar isWrapping
			  ifFalse: [
				  bar isVertical
					  ifTrue: [
						  bar isHMatchParent
							  ifTrue: [ aNode hMatchParent ]
							  ifFalse: [ aNode hFitContent ].
						  bar autoDistribute
							  ifTrue: [ aNode vMatchParent ]
							  ifFalse: [ aNode vFitContent ] ]
					  ifFalse: [
						  bar isVMatchParent
							  ifTrue: [ aNode vMatchParent ]
							  ifFalse: [ aNode vFitContent ].
						  bar autoDistribute
							  ifTrue: [ aNode hMatchParent ]
							  ifFalse: [ aNode hFitContent ] ] ]
			  ifTrue: [ aNode fitContent ].

		  bar autoDistribute ifTrue: [
			  bar isHorizontal
				  ifTrue: [ aNode hMatchParent ]
				  ifFalse: [ aNode vMatchParent ] ] ]
]
