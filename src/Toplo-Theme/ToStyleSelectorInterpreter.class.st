Class {
	#name : #ToStyleSelectorInterpreter,
	#superclass : #ToStyleSelectorVisitor,
	#instVars : [
		'targetStack',
		'result'
	],
	#category : #'Toplo-Theme-StyleSelector'
}

{ #category : #operating }
ToStyleSelectorInterpreter >> check: aSelector on: anElement [

	targetStack := Stack new.
	targetStack push: anElement.
	result := true.
	aSelector accept: self.
	^ result
]

{ #category : #accessing }
ToStyleSelectorInterpreter >> result [

	^ result
]

{ #category : #visiting }
ToStyleSelectorInterpreter >> visitAndSelector: aSelector [

	aSelector left accept: self.
	result ifFalse: [ ^ self ].
	aSelector right accept: self.
]

{ #category : #visiting }
ToStyleSelectorInterpreter >> visitChildSelector: aSelector [

	| current l |
	aSelector left accept: self.
	result ifFalse: [ ^ self ].

	result := false.
	current := targetStack top parent.
	l := aSelector parentLevel - 1.
	(current isNil or: [ l < 0 ]) ifTrue: [
		^ self ].
	
	[ current isNil or: [ result ] ] whileFalse: [
		targetStack push: current.
		aSelector right accept: self.
		targetStack pop.
		(result and: [l > 0]) ifTrue: [
			result := false.
			^ self ].
		(result not and: [l  = 0]) ifTrue: [ 
			result := false.
			^ self ].
		result ifFalse: [ l := l - 1 ].
		current := current parent ].

	result := result and: [ l isZero ]
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
ToStyleSelectorInterpreter >> visitStyleClassSelector: aSelector [

	result := targetStack top styleClasses includesAll: aSelector styleClasses  
]

{ #category : #visiting }
ToStyleSelectorInterpreter >> visitTypeSelector: aSelector [

	result := (aSelector selectType: targetStack top class)
]

{ #category : #visiting }
ToStyleSelectorInterpreter >> visitUniversalSelector: aSelector [

	result := true
]
