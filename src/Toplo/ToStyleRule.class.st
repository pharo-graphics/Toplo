Class {
	#name : 'ToStyleRule',
	#superclass : 'Object',
	#traits : 'TToPropertyWritersHolder + TToStyleRulesHolder',
	#classTraits : 'TToPropertyWritersHolder classTrait + TToStyleRulesHolder classTrait',
	#instVars : [
		'selector',
		'subStyleRules',
		'propertyWriters'
	],
	#category : 'Toplo-Core-StyleSheet',
	#package : 'Toplo',
	#tag : 'Core-StyleSheet'
}

{ #category : 'testing' }
ToStyleRule >> canBeAppliedTo: anElement [

	^ self canBeAppliedTo: anElement inTheme: nil
]

{ #category : 'testing' }
ToStyleRule >> canBeAppliedTo: anElement inTheme: aTheme [

	| engine |
	engine := ToSelectorInterpreter new.
	engine theme: aTheme.
	engine check: self selector on: anElement.
	^ engine result
]

{ #category : 'writers selecting' }
ToStyleRule >> canBeFullyAppliedTo: anElement forTheme: aTheme [

	" for testing purpose. "
	(self canBeAppliedTo: anElement inTheme: aTheme) ifFalse: [ ^ false ].
	^ self styleRules allSatisfy: [ :r |
		  r canBeFullyAppliedTo: anElement forTheme: aTheme ]
]

{ #category : 'copying' }
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

{ #category : 'accessing' }
ToStyleRule >> eventClass [

	^ ToInstallLookEvent 
]

{ #category : 'initialization' }
ToStyleRule >> initialize [

	super initialize.
	selector := ToUniversalSelector new.
	self rawPropertyWriters: #(  ).
	self rawStyleRules: #(  )
]

{ #category : 'writers selecting' }
ToStyleRule >> putApplicableWritersForElement: anElement forTheme: aTheme in: aStream [

	(self canBeAppliedTo: anElement inTheme: aTheme) ifFalse: [ ^ self ].
	aStream nextPutAll: self propertyWriters.
	self styleRules do: [ :r | r putApplicableWritersForElement: anElement forTheme: aTheme in: aStream ] 
]

{ #category : 't - property writers holder - accessing' }
ToStyleRule >> rawPropertyWriters [

	^ propertyWriters
]

{ #category : 't - property writers holder - accessing' }
ToStyleRule >> rawPropertyWriters: aPropertyWriterCollection [

	propertyWriters := aPropertyWriterCollection 
]

{ #category : 't - style rules holder' }
ToStyleRule >> rawStyleRules [

	^ subStyleRules
]

{ #category : 't - style rules holder' }
ToStyleRule >> rawStyleRules: aStyleRuleCollection [

	subStyleRules := aStyleRuleCollection
]

{ #category : 'accessing' }
ToStyleRule >> selector [

	^ selector
]

{ #category : 'accessing' }
ToStyleRule >> selector: aStyleSelector [

	selector := aStyleSelector
]
