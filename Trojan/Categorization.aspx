<%@ Page Title="Trojan Categorization" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Categorization.aspx.cs" Inherits="Trojan.Categorization" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %></h2>
    <p>The growing concern for the safety of processor hardware has spawned the need for new security measures. To aid in the investigation of hardware trojan viruses a new technique for categorization and analysis has been developed; this technique however requires considerable computational efforts. 
       The categorizaton tool expedites the employment of this new technique.</p>

    <h3>Attributes</h3>
    <p>Several researchers have proposed taxonomies for hardware
        trojans based on their attributes [1]–[5]. In [4], hardware
        trojans were classified based on two categories: trigger and
        payload. These are in fact activation mechanisms for trojans.
        In [3] and [5], the classification was based on three categories:
        physical, activation, and action. Although this adds
        two categories to the previous taxonomy, the classification
        is not related to the chip life-cycle. In [2], a more detailed
        classification was developed based on five categories: insertion
        phase, abstraction level, activation mechanism, effect, and
        location. This classification considers the chip life-cycle and
        the targeted location, but not the physical characteristics of
        trojans. The taxonomy in [2] was tested using a set of trojans
        to verify the classification, and the attributes corresponding to
        each trojan was identified. However, the relationship between
        the attributes associated with a hardware trojan has not been
        investigated in the literature.</p>
    <div>&nbsp&nbsp&nbsp&nbsp</div>

        <div style="align-content:center; text-align:center; padding-bottom: 10px" class="jumbotron">
            <img src="Images/IC_life_cycle.png" />
            <br><br><br>
            <figcaption class="label label-default">Fig. 1 - The Integrated Circuit (IC) Design Life-Cycle Phases</figcaption>
        </div>
    <div>&nbsp&nbsp&nbsp&nbsp</div>
        <p>The new methodology used in the categorization tool is flexible and can be used
        with any hardware trojan classification. Further, new attributes
        based on technology or chip manufacturing developments can
        easily be accommodated. As with any circuit, a hardware
        trojan goes through several production phases as it becomes
        embedded into the target system. Therefore, studying the life
        cycle along with other attributes will provide a better insight
        into the insertion phase, functionality, logic type, physical
        characteristics, and location of a trojan.</p>
    <div>&nbsp&nbsp&nbsp&nbsp</div>
    <div style="align-content:center; text-align:center; padding-bottom: 10px" class="jumbotron">
        <img src="Images/HW_trojan.png" style="width: 50%; height:50%" />
        <br><br><br>
        <figcaption class="label label-default">Fig. 2 - Hardware Trojan Taxonomy</figcaption>
    </div>
    <div>&nbsp&nbsp&nbsp&nbsp</div>
    <p>The image above shows the grouping of each of the attributes group into their respective categories. Each of these categories are then re-organized into further "main" categories.</p>
    <div>&nbsp&nbsp&nbsp&nbsp</div>
    <div style="align-content:center; text-align:center; padding-bottom: 10px" class="jumbotron">
        <img src="Images/trojan_life_cycle.png" />
        <br><br><br>
        <figcaption class="label label-default">Fig. 3 - The Four Main Hardware Trojan Levels</figcaption>
    </div>
    <div>&nbsp&nbsp&nbsp&nbsp</div><div>&nbsp&nbsp&nbsp&nbsp</div>

    <section id="citations">
        <div>&nbsp&nbsp&nbsp</div>
        <h4>Citations</h4>
        <p>[1] S. Moein, T. Aaron Gulliver and F. Gebali A New Characterization of
                Hardware Trojan Attributes, IEEE Transaction on Security and Forensics,
                submitted.
        </p>
        <p>[2] R. Karri, J. Rajendra, K. Rosenfeld, and M. Tehranipoor, “Trustworthy
                hardware: Identifying and classifying hardware trojans,” Computer, vol.
                Computer 43.10, no. 10, pp. 39–46, 2010.</p>
        <p>[3] M. T. RM. Rad, X. Wang and J. Plusquellic, “Power supply signal
                calibration techniques for improving detection resolution to hardware
                trojans,” IEEE/ACM International Conference on Computer-Aided Design,
                pp. 632–639, 2008.</p>
        <p>[4] F. Wolff, C. Papachristou, S. Bhunia, and R. Chakraborty, “Towards
                trojan-free trusted ics: Problem analysis and detection scheme,” In
                Design,</p>
        <p>[5] X. Wang, M. Tehranipoor, and J. Plusquellic, “Detecting malicious
                inclusions in secure hardware: Challenges and solutions,” Hardware-
                Oriented Security and Trust, pp. 15–19, 2008.</p>
    </section>
</asp:Content>
