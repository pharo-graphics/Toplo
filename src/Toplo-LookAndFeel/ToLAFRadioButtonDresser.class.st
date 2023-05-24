Class {
	#name : #ToLAFRadioButtonDresser,
	#superclass : #ToAbstractButtonDresser,
	#traits : 'TToSkinnableElementDresser',
	#classTraits : 'TToSkinnableElementDresser classTrait',
	#instVars : [
		'checkedIcon',
		'indeterminateIcon',
		'uncheckedIcon'
	],
	#category : #'Toplo-LookAndFeel-Dressers'
}

{ #category : #accessing }
ToLAFRadioButtonDresser >> checkIndeterminateIn: anElement [

	anElement hasIndeterminateState
		ifTrue: [ self withIndeterminateIn: anElement ]
		ifFalse: [ self withoutIndeterminateIn: anElement ].

]

{ #category : #accessing }
ToLAFRadioButtonDresser >> defaultCheckedIconImage: anElement [

	^ checkedIcon ifNil: [| icon |
		  icon := BlElement new.
		  anElement skin checkedSize ifNotNil: [ :e | icon size: e ].
		  anElement skin checkedBorder ifNotNil: [ :e | icon border: e ].
		  anElement skin checkedMargin ifNotNil: [ :e | icon margin: e ].
		  anElement skin checkedGeometry ifNotNil: [ :e | icon geometry: e ].
		  anElement skin checkedBackground ifNotNil: [ :e | icon background: e ].
		  checkedIcon := ToImage inner: icon ]
]

{ #category : #accessing }
ToLAFRadioButtonDresser >> defaultCheckedState [

	^ ToWidgetState new
		  name: #checked;
		  whenEnterDo: [ :ann |
			  ann widget icon: (self defaultCheckedIconImage: ann widget) ];
		  yourself
]

{ #category : #accessing }
ToLAFRadioButtonDresser >> defaultIndeterminateIconImage: anElement [

	^ indeterminateIcon ifNil: [ | icon |
		  icon := BlElement new.
		  anElement skin indeterminateSize ifNotNil: [ :e | icon size: e ].
		  anElement skin indeterminateBorder ifNotNil: [ :e | icon border: e ].
		  anElement skin indeterminateMargin ifNotNil: [ :e | icon margin: e ].
		  anElement skin indeterminateGeometry ifNotNil: [ :e | icon geometry: e ].
		  anElement skin indeterminateBackground ifNotNil: [ :e | icon background: e ].
		  indeterminateIcon := ToImage inner: icon ]
]

{ #category : #accessing }
ToLAFRadioButtonDresser >> defaultIndeterminateState [

	^ ToWidgetState new
		  name: #indeterminate;
		  whenEnterDo: [ :ann | 
			  ann widget icon: (self defaultIndeterminateIconImage: ann widget) ];
		  yourself
]

{ #category : #accessing }
ToLAFRadioButtonDresser >> defaultToElementClass [

	^ ToRadioButton
]

{ #category : #accessing }
ToLAFRadioButtonDresser >> defaultUncheckedIconImage: anElement [

	^ uncheckedIcon ifNil: [| icon |
		  icon := BlElement new.
		  anElement skin uncheckedSize ifNotNil: [ :e | icon size: e ].
		  anElement skin uncheckedBorder ifNotNil: [ :e | icon border: e ].
		  anElement skin uncheckedMargin ifNotNil: [ :e | icon margin: e ].
		  anElement skin uncheckedGeometry ifNotNil: [ :e | icon geometry: e ].
		  anElement skin uncheckedBackground ifNotNil: [ :e | icon background: e ].
		  uncheckedIcon := ToImage inner: icon ]
]

{ #category : #accessing }
ToLAFRadioButtonDresser >> defaultUncheckedState [

	^ ToWidgetState new
		  name: #unchecked;
		  whenEnterDo: [ :ann | 
			  ann widget icon: (self defaultUncheckedIconImage: ann widget) ]
]

{ #category : #'events handling' }
ToLAFRadioButtonDresser >> escaped: anElement [

	

]

{ #category : #accessing }
ToLAFRadioButtonDresser >> hover: anElement event: anEvent [

	super hover: anElement event: anEvent.

	"update main element"
	self background: self skin backgroundHover in: anElement.
	self border: self skin borderHover in: anElement.

	"update checked/unchecked icon"
	anElement isChecked
		ifTrue: [
			self skin checkedBorderHover ifNotNil: [:e | anElement icon innerImage border: e].
			self skin checkedBackgroundHover ifNotNil: [:e | anElement icon innerImage background: e]]
		ifFalse: [
			self skin uncheckedBorderHover ifNotNil: [:e | anElement icon innerImage border: e].
			self skin uncheckedBackgroundHover ifNotNil: [:e | anElement icon innerImage background: e]]
]

{ #category : #accessing }
ToLAFRadioButtonDresser >> initialState: anElement [

	super initialState: anElement.

	"update main element"
	self background: self skin background in: anElement.
	self border: self skin border in: anElement.
	
	"update checked/unchecked icon"
	anElement isChecked
		ifTrue: [
			self skin checkedBorder ifNotNil: [:e | anElement icon innerImage border: e].
			self skin checkedBackground ifNotNil: [:e | anElement icon innerImage background: e]]
		ifFalse: [
			self skin uncheckedBorder ifNotNil: [:e | anElement icon innerImage border: e].
			self skin uncheckedBackground ifNotNil: [:e | anElement icon innerImage background: e]]
]

{ #category : #accessing }
ToLAFRadioButtonDresser >> isSkinCompatible: aSkin [

	aSkin ifNil:[ ^ false ].
	self flag:'Labordep this is dirty, need to find a better solution'.
	^ aSkin isKindOf: ToAbstractCheckButtonSkin
]

{ #category : #'events handling' }
ToLAFRadioButtonDresser >> leaved: anElement [

	self initialState: anElement.

]

{ #category : #'events handling' }
ToLAFRadioButtonDresser >> onInstalledIn: anElement [

	skin := anElement skin.
	self skin theme: anElement toTheme.
	self haveCompatibleSkin ifFalse:[^ self].	
	
	super onInstalledIn: anElement.
	self initialState: anElement.

	anElement geometry: self skin builtGeometry.
	
	self skin defaultSize ifNotNil:[ :aPoint | 
		anElement constraintsDo:[ :c | 
			aPoint y > 0 ifTrue:[ c vertical exact: aPoint y ].
			aPoint x > 0 ifTrue:[ c horizontal exact: aPoint x ].
		].
	].
	anElement background: self skin background.
	anElement padding: self skin padding.
	anElement effect: self skin shadow.
	
	self checkIndeterminateIn: anElement.
	" In case of a dresser change, the checkable must be added here in the group 
	to plug the state actions 
	(see ToCheckableGroupStrategy>>#buttonInserted:in: ) 
	related to https://github.com/plantec/Toplo/issues/28 "
	anElement group ifNotNil: [ :grp | grp add: anElement ].
	anElement
		whenAnnouncement: ToStatesDefinitionChangedAnnouncement
		do: [ self checkIndeterminateIn: anElement ].
		
	self skin onInstalledIn: anElement.
]

{ #category : #'events handling' }
ToLAFRadioButtonDresser >> onUninstalledIn: anElement [

	self skin onUninstalledIn: anElement.
	super onUninstalledIn: anElement.
	skin := nil.
	anElement
		whenAnnouncement: ToStatesDefinitionChangedAnnouncement
		do: [].
	
	self skin onUninstalledIn: anElement.
]

{ #category : #'events handling' }
ToLAFRadioButtonDresser >> withIndeterminateIn: anElement [

	anElement setUpStatesWith: { 
			self defaultIndeterminateState.
			self defaultCheckedState.
			self defaultUncheckedState }
]

{ #category : #'events handling' }
ToLAFRadioButtonDresser >> withoutIndeterminateIn: anElement [

	anElement setUpStatesWith: { 
			self defaultUncheckedState.
			self defaultCheckedState }
]
