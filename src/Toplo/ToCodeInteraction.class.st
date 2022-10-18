Class {
	#name : #ToCodeInteraction,
	#superclass : #Object,
	#instVars : [
		'owner'
	],
	#category : #'Toplo-Widgets'
}

{ #category : #accessing }
ToCodeInteraction >> behavior [

	^ nil
]

{ #category : #binding }
ToCodeInteraction >> bindingOf: aString [

	^ nil
]

{ #category : #accessing }
ToCodeInteraction >> bindings [

	"no additional bindings provided by the Requestor"

	^ #() asDictionary
]

{ #category : #accessing }
ToCodeInteraction >> doItContext [

	^ nil
]

{ #category : #accessing }
ToCodeInteraction >> doItReceiver [

	^ nil
]

{ #category : #binding }
ToCodeInteraction >> hasBindingOf: aString [

	^ false
]

{ #category : #testing }
ToCodeInteraction >> hasBindingThatBeginsWith: aString [

	^ self variableBindingNames 
		anySatisfy: [ :each | each beginsWith: aString ]
]

{ #category : #testing }
ToCodeInteraction >> isScripting [

	^ false
]

{ #category : #'interactive error protocol' }
ToCodeInteraction >> notify: message at: location in: code [

]

{ #category : #'api - hooks' }
ToCodeInteraction >> onInstalledIn: aViewModel [
]

{ #category : #'api - hooks' }
ToCodeInteraction >> onUninstalledIn: aViewModel [
]

{ #category : #accessing }
ToCodeInteraction >> owner [

	^ owner
]

{ #category : #accessing }
ToCodeInteraction >> owner: aPresenter [

	owner := aPresenter
]

{ #category : #accessing }
ToCodeInteraction >> selectedBehavior [

	^ self behavior
]

{ #category : #accessing }
ToCodeInteraction >> selectedClass [

	^ self behavior
]

{ #category : #accessing }
ToCodeInteraction >> selectedClassOrMetaClass [

	^ self behavior
]

{ #category : #accessing }
ToCodeInteraction >> text [

	^ self owner text
]

{ #category : #accessing }
ToCodeInteraction >> variableBindingNames [
	
	^ self variableBindings keys
]

{ #category : #accessing }
ToCodeInteraction >> variableBindings [

	^ Dictionary new
]
