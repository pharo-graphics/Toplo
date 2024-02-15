Class {
	#name : #ToThemeEditorRuleObserverForTest,
	#superclass : #Object,
	#traits : 'TToThemeEditorRulesTreeObserver',
	#classTraits : 'TToThemeEditorRulesTreeObserver classTrait',
	#instVars : [
		'styleRule',
		'count'
	],
	#category : #'Toplo-IDE-theme-editor-presenter-rulesTree'
}

{ #category : #accessing }
ToThemeEditorRuleObserverForTest >> count [

	^ count
]

{ #category : #initialization }
ToThemeEditorRuleObserverForTest >> initialize [

	count := 0
]

{ #category : #initialization }
ToThemeEditorRuleObserverForTest >> selectedRuleChanged: aToStyleRule [

	self styleRule: aToStyleRule.
	count := count + 1.
]

{ #category : #accessing }
ToThemeEditorRuleObserverForTest >> styleRule [

	^ styleRule
]

{ #category : #accessing }
ToThemeEditorRuleObserverForTest >> styleRule: anObject [

	styleRule := anObject
]
