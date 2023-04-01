Class {
	#name : #ToAbstractTheme,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#classInstVars : [
		'current'
	],
	#category : #'Toplo-LookAndFeel-Core'
}

{ #category : #cleanup }
ToAbstractTheme class >> cleanUp [
	<script>

	current := nil
]

{ #category : #cleanup }
ToAbstractTheme class >> cleanUp: anObject [

	self cleanUp
]

{ #category : #current }
ToAbstractTheme class >> current [

	current ifNil: [ current := ToThemeLight new ].
	^ current
]

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

	| skinClasses type skinClass |
	skinClasses := self skinClassesFor: aToElementClass.
	type := aType ifNil:[ ToAbstractSkin defaultType ].
	
	skinClass := skinClasses detect: [ :e | e type = type ] ifNone: [ skinClasses first ].
	^ skinClass new
]

{ #category : #colors }
ToAbstractTheme >> backgroundColor [

	^ Color white
]

{ #category : #colors }
ToAbstractTheme >> darkTheme [

	^ self subclassResponsibility
]

{ #category : #colors }
ToAbstractTheme >> isDark [

	^ self subclassResponsibility
]

{ #category : #colors }
ToAbstractTheme >> isLight [

	^ self subclassResponsibility
]

{ #category : #colors }
ToAbstractTheme >> lightTheme [

	^ self subclassResponsibility
]

{ #category : #accessing }
ToAbstractTheme >> name [

	^ name ifNil:[ name := 'No name Theme' ]
]

{ #category : #accessing }
ToAbstractTheme >> name: anObject [

	name := anObject
]
