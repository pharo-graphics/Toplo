Class {
	#name : #ToStyleRule,
	#superclass : #Object,
	#traits : 'TToLookEventListenerRegistry + TToStyleRulesHolder',
	#classTraits : 'TToLookEventListenerRegistry classTrait + TToStyleRulesHolder classTrait',
	#instVars : [
		'selector',
		'subStyleRules',
		'skinEventListeners'
	],
	#category : #'Toplo-Core-StyleSheet'
}

{ #category : #visiting }
ToStyleRule >> accept: aVisitor [

	aVisitor visitStyleRule: self.
]

{ #category : #testing }
ToStyleRule >> canBeAppliedTo: anElement [

	^ self canBeAppliedTo: anElement inTheme: nil
]

{ #category : #testing }
ToStyleRule >> canBeAppliedTo: anElement inTheme: aTheme [

	" check if my rules are applicable to the element.
	aTheme is used to setup the element *** before *** evaluating rules.
	see ToTheme>>setUpElement: "

	| engine |
	engine := ToSelectorInterpreter new.
	engine theme: aTheme.
	engine check: self selector on: anElement.
	^ engine result
]

{ #category : #'private - for tests implementation  only' }
ToStyleRule >> canBeRecursivelyAppliedTo: anElement forTheme: aTheme [

	" I'm an helper for testing purpose. **** It does'nt make sense to use this method for writer interpreting *** "
	" check if my rules are applicable to the element.
	aTheme is used to set-up the element *** before *** evaluating rules.
	see ToTheme>>setUpElementForTheme: "
	
	(self canBeAppliedTo: anElement inTheme: aTheme) ifFalse: [ ^ false ].
	^ self styleRules allSatisfy: [ :r |
		  r canBeRecursivelyAppliedTo: anElement forTheme: aTheme ]
]

{ #category : #copying }
ToStyleRule >> copyWithOnlyApplicableRuleFor: anElement inTheme: aTheme [

	| copy |
	(self canBeAppliedTo: anElement inTheme: aTheme) ifFalse: [ ^ nil ].
	copy := self copy.
	copy styleRules: #(  ).
	self styleRules do: [ :r |
		(r copyWithOnlyApplicableRuleFor: anElement inTheme: aTheme) ifNotNil: [ :e |
			copy addStyleRule: e ] ].
	^ copy
]

{ #category : #initialization }
ToStyleRule >> initialize [

	super initialize.
	selector := ToUniversalSelector new.
	self rawStyleRules: #(  )
]

{ #category : #'listener selecting' }
ToStyleRule >> putApplicableListenersForElement: anElement forTheme: aTheme in: aStream [

	(self canBeAppliedTo: anElement inTheme: aTheme) ifFalse: [ ^ self ].
	aStream nextPutAll: self skinEventListeners.
	self styleRules do: [ :r | r putApplicableListenersForElement: anElement forTheme: aTheme in: aStream ] 
]

{ #category : #'t - skin event listener registry' }
ToStyleRule >> rawSkinEventListeners [

	^ skinEventListeners
]

{ #category : #'t - skin event listener registry' }
ToStyleRule >> rawSkinEventListeners: aSkinEventListenerCollection [

	skinEventListeners := aSkinEventListenerCollection
]

{ #category : #'t - style rules holder' }
ToStyleRule >> rawStyleRules [

	^ subStyleRules
]

{ #category : #'t - style rules holder' }
ToStyleRule >> rawStyleRules: aStyleRuleCollection [

	subStyleRules := aStyleRuleCollection
]

{ #category : #accessing }
ToStyleRule >> selector [

	^ selector
]

{ #category : #accessing }
ToStyleRule >> selector: aStyleSelector [

	selector := aStyleSelector
]
