Class {
	#name : #ToElementSelectorEngine,
	#superclass : #ToSelectorVisitor,
	#instVars : [
		'targetStack',
		'result'
	],
	#category : #'Toplo-Theme-StyleSheet'
}

{ #category : #operating }
ToElementSelectorEngine >> check: aSelector on: anElement [

	targetStack := Stack new.
	targetStack push: anElement.
	result := true.
	aSelector accept: self.
	^ result
]

{ #category : #accessing }
ToElementSelectorEngine >> result [

	^ result
]

{ #category : #visiting }
ToElementSelectorEngine >> visitAndSelector: aSelector [

	aSelector left accept: self.
	result ifFalse: [ ^ self ].
	aSelector right accept: self.
]

{ #category : #visiting }
ToElementSelectorEngine >> visitChildSelector: aSelector [

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
ToElementSelectorEngine >> visitIdSelector: aSelector [

	result := aSelector id = targetStack top id
]

{ #category : #visiting }
ToElementSelectorEngine >> visitStyleClassSelector: aSelector [

	result := aSelector styleClasses includesAll: targetStack top styleClasses
]

{ #category : #visiting }
ToElementSelectorEngine >> visitTypeSelector: aSelector [

	result := (aSelector selectType: targetStack top class)
]

{ #category : #visiting }
ToElementSelectorEngine >> visitUniversalSelector: aSelector [

	result := true
]
