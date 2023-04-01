Class {
	#name : #ToAbstractTheme,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'Toplo-LookAndFeel-Theme'
}

{ #category : #dresser }
ToAbstractTheme class >> dresserFor: aToElementClass [
	"return dresser which manage this theme"

	^ self subclassResponsibility 
]

{ #category : #testing }
ToAbstractTheme class >> isAbstract [

	^ self = ToAbstractTheme
]

{ #category : #skins }
ToAbstractTheme class >> skinClassesFor: aToElementClass [
	"return skins which are designed for this theme"
	
	^ self subclassResponsibility
]

{ #category : #skins }
ToAbstractTheme class >> skinFor: aToElementClass type: aType [
	"return skin which are designed for this theme and a specified type"

	| skinClasses |
	skinClasses := self skinClassesFor: aToElementClass.
	^ (skinClasses detect: [ :e | e type = aType ] ifNone: [ nil ]) new
]

{ #category : #colors }
ToAbstractTheme >> backgroundColor [

	^ Color white
]

{ #category : #accessing }
ToAbstractTheme >> name [

	^ name ifNil:[ name := 'Theme without name' ]
]

{ #category : #accessing }
ToAbstractTheme >> name: anObject [

	name := anObject
]
