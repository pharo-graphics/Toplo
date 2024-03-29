Class {
	#name : #ToObservableCollectionMirrorUpdater,
	#superclass : #ToObservableCollectionEventHandler,
	#instVars : [
		'mirror'
	],
	#category : #'Toplo-Core-Collection'
}

{ #category : #'data events handling' }
ToObservableCollectionMirrorUpdater >> collectionAddEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	mirror updateAllWith: target
]

{ #category : #'data events handling' }
ToObservableCollectionMirrorUpdater >> collectionAllUpdatedEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	mirror updateAllWith: target
]

{ #category : #'data events handling' }
ToObservableCollectionMirrorUpdater >> collectionRemoveEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	mirror updateAllWith: target
]

{ #category : #'data events handling' }
ToObservableCollectionMirrorUpdater >> collectionUpdateEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	mirror updateAllWith: target
]

{ #category : #accessing }
ToObservableCollectionMirrorUpdater >> mirror [

	^ mirror
]

{ #category : #accessing }
ToObservableCollectionMirrorUpdater >> mirror: anObservableCollection [

	mirror ifNotNil: [ ^ (BlImmutableObjectChangeError object: self) signal ].
	mirror := anObservableCollection
]

{ #category : #'api - hooks' }
ToObservableCollectionMirrorUpdater >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	mirror ifNil: [ ^ Error signal: 'The mirror instance variable must be initialize' ].
	mirror updateAllWith: anElement
]

{ #category : #'api - hooks' }
ToObservableCollectionMirrorUpdater >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	mirror := nil
]
