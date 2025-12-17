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
ToFiniteListNodeContainer >> applyConfiguration [

	| finiteList |
	super applyConfiguration.
	finiteList := self holder listElement.
	finiteList isFlowable
		ifTrue: [ self fitContent ]
		ifFalse: [
				finiteList isVertical
					ifTrue: [
							finiteList isHMatchParent
								ifTrue: [ self hMatchParent ]
								ifFalse: [ self hFitContent ].
							finiteList autoDistribute
								ifTrue: [ self vMatchParent ]
								ifFalse: [ self vFitContent ] ]
					ifFalse: [
							finiteList isVMatchParent
								ifTrue: [ self vMatchParent ]
								ifFalse: [ self vFitContent ].
							finiteList autoDistribute
								ifTrue: [ self hMatchParent ]
								ifFalse: [ self hFitContent ] ] ]
]
