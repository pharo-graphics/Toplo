Class {
	#name : #ToCompanion,
	#superclass : #Object,
	#traits : 'TToObservable + TBlAnnouncerProvider',
	#classTraits : 'TToObservable classTrait + TBlAnnouncerProvider classTrait',
	#instVars : [
		'userData',
		'installed'
	],
	#category : #'Toplo-Core'
}

{ #category : #converting }
ToCompanion class >> asLook [
	^ self new asLook
]

{ #category : #'api - install/uninstall  hook' }
ToCompanion >> afterInstallationIn: anElement [
]

{ #category : #'api - install/uninstall  hook' }
ToCompanion >> allowInstallationIn: anElement [

	installed ifTrue: [ ^ false ].
	installed := true.
	^ true
]

{ #category : #'api - install/uninstall  hook' }
ToCompanion >> allowUninstallationIn: anElement [

	installed ifFalse: [ ^ false ].
	installed := false.
	^ true
]

{ #category : #'api - install/uninstall  hook' }
ToCompanion >> beforeInstallationIn: anElement [
]

{ #category : #initialization }
ToCompanion >> initialize [
	self class initializeSlots: self.
	super initialize.
	installed := false.
	privateAnnouncer := Announcer new
]

{ #category : #'api - install/uninstall  hook' }
ToCompanion >> launchInstallationIn: anElement [

	(self allowInstallationIn: anElement) ifFalse: [ ^ self ].
	self beforeInstallationIn: anElement.
	self onInstalledIn: anElement.
	self afterInstallationIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToCompanion >> launchUninstallationIn: anElement [

	(self allowUninstallationIn: anElement) ifFalse: [ ^ self ].
	self onUninstalledIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToCompanion >> onInstalledIn: anElement [

]

{ #category : #'api - install/uninstall  hook' }
ToCompanion >> onUninstalledIn: anElement [

]

{ #category : #accessing }
ToCompanion >> userData [
	"Returns a Dictionary that holds application dependent and temporary objects.
	Be careful to limit the use of such facility and prefer clean instance variables when it is possible to define them.
	If a user data is used, to ensure maintainability, systematically define relevant accessors and a relase method to get, set and remove
	the user data. The use of the key (which is most of time a symbol ) inside other method is strongly not recommended
	"
	<return: #Dictionary>

	^ userData ifNil: [ userData := IdentityDictionary new ]
]
