Class {
	#name : #ToNullDresser,
	#superclass : #ToCompanion,
	#category : #'Toplo-Core'
}

{ #category : #'api - install/uninstall  hook' }
ToNullDresser >> addDresser: aDresser in: anElement [

	aDresser next: self.
	anElement dresser: aDresser.
]

{ #category : #'api - install/uninstall  hook' }
ToNullDresser >> addDresser: aDresser in: anElement previous: aPreviousDresser [

	aDresser next: self.
	aPreviousDresser next: aDresser.
	aDresser launchInstallationIn: anElement
]

{ #category : #'accessing - dresser' }
ToNullDresser >> dresserSatisfying: aBlock [

	^ nil
]

{ #category : #'events handling' }
ToNullDresser >> element: anElement addedInInfiniteDecoration: aDecoration [
]

{ #category : #'events handling' }
ToNullDresser >> element: anElement removedFromInfiniteDecoration: aSelectionDecoration [
]

{ #category : #'api - install/uninstall  hook' }
ToNullDresser >> next: aDresser [
]

{ #category : #'api - install/uninstall  hook' }
ToNullDresser >> onInstalledIn: anElement [

]

{ #category : #'api - install/uninstall  hook' }
ToNullDresser >> onUninstalledIn: anElement [

]

{ #category : #'api - install/uninstall  hook' }
ToNullDresser >> removeDresser: aDresser in: anElement [
]
