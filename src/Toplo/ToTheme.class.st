Class {
	#name : 'ToTheme',
	#superclass : 'Object',
	#classInstVars : [
		'current'
	],
	#category : 'Toplo-Core-Theme',
	#package : 'Toplo',
	#tag : 'Core-Theme'
}

{ #category : 'cleanup' }
ToTheme class >> cleanUp [
	<script>

	current := nil
]

{ #category : 'cleanup' }
ToTheme class >> cleanUp: anObject [

	self cleanUp
]

{ #category : 'current' }
ToTheme class >> current [

	^ current ifNil: [ current := ToRawTheme new ]
]

{ #category : 'accessing' }
ToTheme >> name [

	^ self subclassResponsibility 
]

{ #category : 'accessing' }
ToTheme >> newSkinFor: anElement [

	anElement setUpForTheme: self.
	^ self newSkinInstanceFor: anElement
]

{ #category : 'accessing' }
ToTheme >> newSkinInstanceFor: anElement [

	^ self subclassResponsibility 
]

{ #category : 'instance creation' }
ToTheme >> newStampIndexFromStampList: aStyleStampCollection [

	^ ToPropertyIndex new addAllProperties: aStyleStampCollection; yourself.
]

{ #category : 'hook' }
ToTheme >> onSetUpIn: anElement [
]

{ #category : 'printing' }
ToTheme >> printOn: aStream [

	aStream nextPutAll: '[Theme named: '; nextPutAll: self name; nextPutAll: ' ]'.
	super printOn: aStream
]

{ #category : 'styling' }
ToTheme >> stampNamed: aSymbol [

	^ nil
]

{ #category : 'styling' }
ToTheme >> styleSheet [

	^ nil
]
