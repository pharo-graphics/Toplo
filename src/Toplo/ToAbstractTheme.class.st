Class {
	#name : #ToAbstractTheme,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#classInstVars : [
		'current'
	],
	#category : #'Toplo-Core-Theme'
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

	^ current ifNil: [ current := ToTheme blue ]
]

{ #category : #colors }
ToAbstractTheme >> backgroundColor [

	^ Color white
]

{ #category : #colors }
ToAbstractTheme >> darkTheme [

	^ nil
]

{ #category : #colors }
ToAbstractTheme >> isDark [

	^ false
]

{ #category : #colors }
ToAbstractTheme >> isLight [

	^ false
]

{ #category : #colors }
ToAbstractTheme >> isSupportLightAndDark [

	^ self isLight or: [ self isDark ]
]

{ #category : #colors }
ToAbstractTheme >> lightTheme [

	^ nil
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

	aStream
		nextPutAll: (self name ifNil:[self class name]);
		nextPutAll: ' @ ';
		store: self identityHash
]
