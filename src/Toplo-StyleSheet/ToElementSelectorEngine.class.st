Class {
	#name : #ToElementSelectorEngine,
	#superclass : #ToSelectorVisitor,
	#instVars : [
		'targetStack',
		'result'
	],
	#category : #'Toplo-StyleSheet'
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
ToElementSelectorEngine >> visitChildSelector: aSelector [

	| current |
	current := targetStack top parent.
	current ifNil: [
		result := false.
		^ self ].
	result := false.
	[ current isNil or: [ result ]] whileFalse: [
		targetStack push: current.
		aSelector parentSelector accept: self.
		targetStack pop.
		current := current parent ].
	result ifFalse: [ ^ self ].
	aSelector nextDo: [ :n | n accept: self ]
]

{ #category : #visiting }
ToElementSelectorEngine >> visitClassSelector: aSelector [

	(aSelector elementClasses allSatisfy: [ :c |
		 targetStack top styleClasses includes: c ])
		ifTrue: [ result := true ]
		ifFalse: [
			result := false.
			^ self ].
	aSelector nextDo: [ :n | n accept: self ]
]

{ #category : #visiting }
ToElementSelectorEngine >> visitIdSelector: aSelector [

	aSelector id = targetStack top id ifFalse: [
		result := false.
		^ self ].
	result := true.
	aSelector nextDo: [ :n | n accept: self ]
]

{ #category : #visiting }
ToElementSelectorEngine >> visitTypeSelector: aSelector [

	(aSelector selectType: targetStack top class) ifFalse: [
		result := false.
		^ self ].
	result := true.
	aSelector nextDo: [ :n | n accept: self ]
]

{ #category : #visiting }
ToElementSelectorEngine >> visitUniversalSelector: aSelector [

	result := true.
	aSelector nextDo: [ :n | n accept: self ]
]
