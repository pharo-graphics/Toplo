Class {
	#name : #ToBarNodeConfiguration,
	#superclass : #ToWidgetConfiguration,
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #hook }
ToBarNodeConfiguration >> applyOn: aNode [

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
						ifFalse: [ aNode hFitContent ] ] ].
	aNode holder initializeNode.
	bar exactNodeWidth ifNotNil: [ :w | aNode item width: w ].
	bar exactNodeHeight ifNotNil: [ :h | aNode item height: h ]
	
]
