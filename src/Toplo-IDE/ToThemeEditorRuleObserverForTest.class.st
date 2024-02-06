Class {
	#name : #ToThemeEditorRuleObserverForTest,
	#superclass : #Object,
	#traits : 'TToThemeEditorRulesTreeObserver',
	#classTraits : 'TToThemeEditorRulesTreeObserver classTrait',
	#instVars : [
		'styleRule'
	],
	#category : #'Toplo-IDE-theme-editor-presenter-rulesTree'
}

{ #category : #initialization }
ToThemeEditorRuleObserverForTest >> selectedRuleChanged: aToStyleRule [

	self styleRule: aToStyleRule
]

{ #category : #accessing }
ToThemeEditorRuleObserverForTest >> styleRule [

	^ styleRule
]

{ #category : #accessing }
ToThemeEditorRuleObserverForTest >> styleRule: anObject [

	styleRule := anObject
]
