"
I'm a triplet (start, middle, end) and I'm child of an inner for finite list. 
My role is to contain `ToListNode` element.
"
Class {
	#name : #ToFiniteListNodeContainer,
	#superclass : #ToNodeContainer,
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #configuration }
ToFiniteListNodeContainer >> applyResizerConfiguration [

	| finiteList |
	finiteList := self holder listElement.
	finiteList toConfiguration isFlowable
		ifTrue: [ self fitContent ]
		ifFalse: [
				finiteList isVertical
					ifTrue: [
							finiteList isHMatchParent
								ifTrue: [ self hMatchParent ]
								ifFalse: [ self hFitContent ].
							finiteList toConfiguration autoDistribute
								ifTrue: [ self vMatchParent ]
								ifFalse: [ self vFitContent ] ]
					ifFalse: [
							finiteList isVMatchParent
								ifTrue: [ self vMatchParent ]
								ifFalse: [ self vFitContent ].
							finiteList toConfiguration autoDistribute
								ifTrue: [ self hMatchParent ]
								ifFalse: [ self hFitContent ] ] ]
]
