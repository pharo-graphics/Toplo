Class {
	#name : 'ToSelectorInterpreter',
	#superclass : 'ToElementSelectorVisitor',
	#instVars : [
		'theme',
		'targetStack',
		'result'
	],
	#category : 'Toplo-Core-Selector',
	#package : 'Toplo',
	#tag : 'Core-Selector'
}

{ #category : 'operating' }
ToSelectorInterpreter >> check: aSelector on: anElement [

	targetStack := Stack new.
	self push: anElement.
	result := true.
	aSelector value accept: self.
	^ result
]

{ #category : 'accessing' }
ToSelectorInterpreter >> pop [

	^ targetStack pop
]

{ #category : 'accessing' }
ToSelectorInterpreter >> push: anElement [

	self themeDo: [ :th | anElement setUpForTheme: th ].
	targetStack push: anElement
]

{ #category : 'accessing' }
ToSelectorInterpreter >> result [

	^ result
]

{ #category : 'accessing' }
ToSelectorInterpreter >> theme [

	^ theme
]

{ #category : 'accessing' }
ToSelectorInterpreter >> theme: aTheme [

	theme := aTheme
]

{ #category : 'accessing' }
ToSelectorInterpreter >> themeDo: aBlock [

	self theme ifNil: [ ^ self ].
	aBlock value: self theme
]

{ #category : 'accessing' }
ToSelectorInterpreter >> top [

	^ targetStack top
]

{ #category : 'visiting' }
ToSelectorInterpreter >> visitActionSelector: aSelector [

	result := aSelector action value: self top
]

{ #category : 'visiting' }
ToSelectorInterpreter >> visitAndSelector: aSelector [

	aSelector left accept: self.
	result ifFalse: [ ^ self ].
	aSelector right accept: self.
]

{ #category : 'visiting' }
ToSelectorInterpreter >> visitChildSelector: aSelector [

	| parent |
	aSelector left accept: self.
	result ifFalse: [ ^ self ].

	result := false.
	parent := self top.
	"evaluate only for children at a given depth or at any depth if selector depth is not specified "
	parent allChildrenBreadthFirstWithDepthDo: [ :child :depth |
		(aSelector depth isNil or: [ aSelector depth = depth ]) ifTrue: [
			self push: child.
			aSelector right accept: self.
			self pop.
			result ifTrue: [ ^ self ] ] ]
]

{ #category : 'visiting' }
ToSelectorInterpreter >> visitIdSelector: aSelector [

	result := aSelector id = self top id
]

{ #category : 'visiting' }
ToSelectorInterpreter >> visitNotSelector: aSelector [

	aSelector left accept: self.
	result := result not
]

{ #category : 'visiting' }
ToSelectorInterpreter >> visitOrSelector: aSelector [

	aSelector left accept: self.
	result ifTrue: [ ^ self ].
	aSelector right accept: self.
]

{ #category : 'visiting' }
ToSelectorInterpreter >> visitParentSelector: aSelector [

	| current depth |
	aSelector left accept: self.
	result ifFalse: [ ^ self ].

	result := false.
	current := self top.
	depth := aSelector depth.

	[
	current := current parent.
	current ifNil: [ ^ self ].
	depth := depth - 1.
	depth < 0 ifTrue: [ ^ self ].
	depth isZero ifTrue: [
		self push: current.
		aSelector right accept: self.
		self pop.
		^ self ] ] repeat
]

{ #category : 'visiting' }
ToSelectorInterpreter >> visitSiblingSelector: aSelector [

	| current |
	aSelector left accept: self.
	result ifFalse: [ ^ self ].

	result := false.
	current := self top.
	current siblingsDo: [ :sib |
		self push: sib.
		aSelector right accept: self.
		self pop.
		result ifTrue: [ ^ self ] ]
]

{ #category : 'visiting' }
ToSelectorInterpreter >> visitStyleStampSelector: aSelector [

	result := aSelector stampNames allSatisfy: [ :t | self top hasTokenPropertyNamed: t ]
]

{ #category : 'visiting' }
ToSelectorInterpreter >> visitTypeSelector: aSelector [

	result := (aSelector selectType: self top class)
]

{ #category : 'visiting' }
ToSelectorInterpreter >> visitUniversalSelector: aSelector [

	result := true
]
