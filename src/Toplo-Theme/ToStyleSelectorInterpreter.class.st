Class {
	#name : #ToStyleSelectorInterpreter,
	#superclass : #ToStyleSelectorVisitor,
	#instVars : [
		'targetStack',
		'result'
	],
	#category : #'Toplo-Theme-StyleOperator'
}

{ #category : #operating }
ToStyleSelectorInterpreter >> check: aSelector on: anElement [

	targetStack := Stack new.
	targetStack push: anElement.
	result := true.
	aSelector value accept: self.
	^ result
]

{ #category : #accessing }
ToStyleSelectorInterpreter >> result [

	^ result
]

{ #category : #visiting }
ToStyleSelectorInterpreter >> visitActionSelector: aSelector [

	result := aSelector action value: targetStack top
]

{ #category : #visiting }
ToStyleSelectorInterpreter >> visitAndSelector: aSelector [

	aSelector left accept: self.
	result ifFalse: [ ^ self ].
	aSelector right accept: self.
]

{ #category : #visiting }
ToStyleSelectorInterpreter >> visitChildSelector: aSelector [

	| parent |
	aSelector left accept: self.
	result ifFalse: [ ^ self ].

	result := false.
	parent := targetStack top.
	"evaluate only for children at a given depth or at any depth if selector depth is not specified "
	parent allChildrenBreadthFirstWithDepthDo: [ :child :depth |
		(aSelector depth isNil or: [ aSelector depth = depth ]) ifTrue: [
			targetStack push: child.
			aSelector right accept: self.
			targetStack pop.
			result ifTrue: [ ^ self ] ] ]
]

{ #category : #visiting }
ToStyleSelectorInterpreter >> visitIdSelector: aSelector [

	result := aSelector id = targetStack top id
]

{ #category : #visiting }
ToStyleSelectorInterpreter >> visitNotSelector: aSelector [

	aSelector left accept: self.
	result := result not
]

{ #category : #visiting }
ToStyleSelectorInterpreter >> visitOrSelector: aSelector [

	aSelector left accept: self.
	result ifTrue: [ ^ self ].
	aSelector right accept: self.
]

{ #category : #visiting }
ToStyleSelectorInterpreter >> visitParentSelector: aSelector [

	| current depth |
	aSelector left accept: self.
	result ifFalse: [ ^ self ].

	result := false.
	current := targetStack top.
	depth := aSelector depth.

	[
	current := current parent.
	current ifNil: [ ^ self ].
	depth := depth - 1.
	depth < 0 ifTrue: [ ^ self ].
	depth isZero ifTrue: [
		targetStack push: current.
		aSelector right accept: self.
		targetStack pop.
		^ self ] ] repeat
]

{ #category : #visiting }
ToStyleSelectorInterpreter >> visitSiblingSelector: aSelector [

	| current |
	aSelector left accept: self.
	result ifFalse: [ ^ self ].

	result := false.
	current := targetStack top.
	current siblingsDo: [ :sib |
		targetStack push: sib.
		aSelector right accept: self.
		targetStack pop.
		result ifTrue: [ ^ self ] ]
]

{ #category : #visiting }
ToStyleSelectorInterpreter >> visitStyleTagSelector: aSelector [

	result := targetStack top styleTags includesAll: aSelector styleTags  
]

{ #category : #visiting }
ToStyleSelectorInterpreter >> visitTypeSelector: aSelector [

	result := (aSelector selectType: targetStack top class)
]

{ #category : #visiting }
ToStyleSelectorInterpreter >> visitUniversalSelector: aSelector [

	result := true
]
