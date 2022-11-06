Class {
	#name : #ToElementCompanion,
	#superclass : #Object,
	#traits : 'TToObservable + TBlAnnouncerProvider',
	#classTraits : 'TToObservable classTrait + TBlAnnouncerProvider classTrait',
	#instVars : [
		'userData'
	],
	#category : #'Toplo-Core'
}

{ #category : #converting }
ToElementCompanion class >> asLook [
	^ self new asLook
]

{ #category : #initialization }
ToElementCompanion >> initialize [
	self class initializeSlots: self.
	super initialize.
	privateAnnouncer := Announcer new
]

{ #category : #'api - hooks' }
ToElementCompanion >> onInstalledIn: anElement [


]

{ #category : #'api - hooks' }
ToElementCompanion >> onUninstalledIn: anElement [

	"Is sent when I am removed from an element "

]

{ #category : #accessing }
ToElementCompanion >> userData [
	"Returns a Dictionary that holds application dependent and temporary objects.
	Be careful to limit the use of such facility and prefer clean instance variables when it is possible to define them.
	If a user data is used, to ensure maintainability, systematically define relevant accessors and a relase method to get, set and remove
	the user data. The use of the key (which is most of time a symbol ) inside other method is strongly not recommended
	"
	<return: #Dictionary>

	^ userData ifNil: [ userData := IdentityDictionary new ]
]
