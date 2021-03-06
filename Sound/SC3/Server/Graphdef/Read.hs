-- | Decode (read) a 'Graphdef' into a 'Graph'.
module Sound.SC3.Server.Graphdef.Read where

import Sound.OSC.Datum {- hosc -}

import Sound.SC3.Server.Graphdef
import qualified Sound.SC3.UGen.Graph as Graph
import qualified Sound.SC3.UGen.Rate as Rate
import qualified Sound.SC3.UGen.Type as Type

control_to_node :: Graphdef -> Type.UID_t -> (Control,Type.Sample) -> Graph.U_Node
control_to_node g z ((nm,ix),v) =
    let z' = graphdef_control_nid g z
        nm' = ascii_to_string nm
    in Graph.U_Node_K z' Rate.KR (Just ix) nm' v Rate.K_KR Nothing

input_to_from_port :: Graphdef -> Input -> Graph.From_Port
input_to_from_port g (Input u p) =
    if u == -1
    then Graph.From_Port_C (graphdef_constant_nid g p)
    else if input_is_control g (Input u p)
         then if u /= 0
              then error "multiple control UGens..."
              else Graph.From_Port_K (graphdef_control_nid g p) Rate.K_KR
         else let ugen = graphdef_ugens g !! u
                  port = if length (ugen_outputs ugen) > 1
                         then Just p
                         else Nothing
              in Graph.From_Port_U (graphdef_ugen_nid g u) port

ugen_to_node :: Graphdef -> Type.UID_t -> UGen -> Graph.U_Node
ugen_to_node g z u =
    let (name,rate,inputs,outputs,special) = u
        z' = graphdef_ugen_nid g z
        rate' = toEnum rate
        name' = ascii_to_string name
        inputs' = map (input_to_from_port g) inputs
        outputs' = map toEnum outputs
        special' = Type.Special special
    in Graph.U_Node_U z' rate' name' inputs' outputs' special' (Type.UId z')

graphdef_to_graph :: Graphdef -> (String,Graph.U_Graph)
graphdef_to_graph g =
    let constants_nd = zipWith Graph.U_Node_C [0..] (graphdef_constants g)
        controls_nd = zipWith (control_to_node g) [0 ..] (graphdef_controls g)
        ugens_nd = zipWith (ugen_to_node g) [0 ..] (graphdef_ugens g)
        nm = ascii_to_string (graphdef_name g)
        gr = Graph.U_Graph (-1) constants_nd controls_nd ugens_nd
    in (nm,gr) -- S.Synthdef nm gr
