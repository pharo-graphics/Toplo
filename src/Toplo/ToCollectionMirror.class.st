Class {
	#name : #ToCollectionMirror,
	#superclass : #ToObservableCollection,
	#instVars : [
		'mirrored',
		'dataUpdater'
	],
	#category : #'Toplo-Core-Collection'
}

{ #category : #accessing }
ToCollectionMirror >> mirrored [

	^ mirrored
]

{ #category : #accessing }
ToCollectionMirror >> mirroredTo: anObservableCollection [

	mirrored = anObservableCollection ifTrue: [ ^ self ].
	mirrored ifNotNil: [ mirrored removeEventHandler: dataUpdater ].
	mirrored := anObservableCollection.
	dataUpdater := ToObservableCollectionMirrorUpdater new mirror: self.
	mirrored addEventHandler: dataUpdater.
]

{ #category : #accessing }
ToCollectionMirror >> unmirrored [

	mirrored ifNil: [ ^ self ].
	mirrored removeEventHandler: dataUpdater
]
