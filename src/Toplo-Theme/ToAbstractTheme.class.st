Class {
	#name : #ToAbstractTheme,
	#superclass : #Object,
	#instVars : [
		'name',
		'styleSheet'
	],
	#classInstVars : [
		'current'
	],
	#category : #'Toplo-Theme-Core'
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

	^ current ifNil: [ current := ToDefaultTheme blue ]
]

{ #category : #accessing }
ToAbstractTheme >> name [

	^ name ifNil:[ name := 'No name Theme' ]
]

{ #category : #accessing }
ToAbstractTheme >> name: anObject [

	name := anObject
]

{ #category : #colors }
ToAbstractTheme >> printOn: aStream [

	aStream nextPutAll: '[Theme named: '; nextPutAll: self name; nextPutAll: ' ]'.
	super printOn: aStream
]

{ #category : #'accessing-skin' }
ToAbstractTheme >> skinFor: anElement [

	^ anElement styleSheet skinFor: anElement
]

{ #category : #accessing }
ToAbstractTheme >> styleSheet [

	^ styleSheet
]

{ #category : #accessing }
ToAbstractTheme >> styleSheet: aStyleSheet [

	styleSheet := aStyleSheet
]
